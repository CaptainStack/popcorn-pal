// Instantiate the Bloodhound suggestion engine
var movies = new Bloodhound({
  datumTokenizer: function (datum) {
    return Bloodhound.tokenizers.whitespace(datum.value);
  },
  queryTokenizer: Bloodhound.tokenizers.whitespace,
  remote: {
    wildcard: '%QUERY',
    url: 'https://www.omdbapi.com/?s=%QUERY&type=movie',
    transform: function (movies) {
      return $.map(movies["Search"], function (movie) {
        return {
          title: movie["Title"],
          year: movie["Year"],
          posterUrl: movie["Poster"],
          imdbID: movie["imdbID"]
        };
      });
    }
  }
});

// Initialize the Bloodhound suggestion engine
movies.initialize();

// Instantiate the Typeahead UI
$('.typeahead').typeahead({
  hint: false
},
{
  name: 'movies',
  display: 'title',
  source: movies.ttAdapter(),
  minLength: 1,
  limit: 3,
  templates: {
    notFound: '<div>No Results Found</div>',
    suggestion: function (movies) {
        return '<li><img class="movie-thumbnail" src="' + movies.posterUrl + '"></img><strong><a>' + movies.title + '</a></strong> (' + movies.year + ')</li>';
      }
  }
}).on('typeahead:asyncrequest', function() {
  $('.typeahead-spinner').show();
  $('.typeahead-icon').hide();
})
.on('typeahead:asynccancel typeahead:asyncreceive', function() {
    $('.typeahead-spinner').hide();
    $('.typeahead-icon').show();
});
