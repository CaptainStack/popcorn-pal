movies = new Bloodhound {
  datumTokenizer: (datum) -> Bloodhound.tikenizers.whitespace(datum.value),
  queryTokenizer: Bloodhound.tokenizers.whitespace,
  remote: {
    wildcard: '%QUERY',
    url: '/movies/tmdb_query/%QUERY',
    transform: (movies) ->
      $.map(movies, (movie) ->
        {
          tmdb_id: movie["id"],
          title: movie["title"],
          release_date: new Date(movie["release_date"]),
          poster_path: movie["poster_path"]
        }
      )
  }
}

# Initialize the Bloodhound suggestion engine
movies.initialize()

# Instantiate the Typeahead UI

$('.typeahead').typeahead({
    hint: false,
    highlight: true
  },
  {
    name: 'movies',
    display: 'title',
    source: movies.ttAdapter()
    minLength: 1,
    limit: 5,
    templates: {
      notFound: '<div>No Results Found</div>',
      suggestion: (movies) ->
        "<li><img class='movie-thumbnail' src=\'https://image.tmdb.org/t/p/w500#{ movies.poster_path }\'></img><a><strong>#{ movies.title }</strong> — (#{ movies.release_date.getFullYear() || "N/A" })</a></li>"
    }
  }
).on('typeahead:asyncrequest', ->
  $('.typeahead-spinner').show()
  $('.typeahead-icon').hide()
).on('typeahead:asynccancel typeahead:asyncreceive', ->
  $('.typeahead-spinner').hide()
  $('.typeahead-icon').show()
).on('typeahead:select', (ev, suggestion) ->
  window.location.replace "/movies/#{ suggestion['tmdb_id'] }"
)
