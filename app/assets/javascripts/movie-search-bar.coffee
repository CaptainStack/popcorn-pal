movies = new Bloodhound {
  datumTokenizer: (datum) -> Bloodhound.tikenizers.whitespace(datum.value),
  queryTokenizer: Bloodhound.tokenizers.whitespace,
  remote: {
    wildcard: '%QUERY',
    url: 'https://api.themoviedb.org/3/search/movie?api_key=ca948b0235f85fbc7a64d9beae013818&query=%QUERY',
    transform: (movies) ->
      $.map(movies["results"], (movie) ->
        {
          title: movie["title"],
          release_year: new Date(movie["release_date"]),
          poster_url: movie["poster_path"]
        }
      )
  }
}

# Initialize the Bloodhound suggestion engine
movies.initialize()

# Instantiate the Typeahead UI

$('.typeahead').typeahead({
    hint: false
  },
  {
    name: 'movies',
    display: 'title',
    source: movies.ttAdapter(),
    minLength: 1,
    limit: 4,
    templates: {
      notFound: '<div>No Results Found</div>',
      suggestion: (movies) ->
        "<li><img class='movie-thumbnail' src=\'https://image.tmdb.org/t/p/w500#{ movies.poster_url }\'></img><a><strong>#{ movies.title }</strong> — (#{ movies.release_year.getFullYear() || "N/A" })</a></li>"
    }
  }
).on('typeahead:asyncrequest', ->
  $('.typeahead-spinner').show()
  $('.typeahead-icon').hide()
)
.on('typeahead:asynccancel typeahead:asyncreceive', ->
  $('.typeahead-spinner').hide()
  $('.typeahead-icon').show()
)
