function moviesList(page) {
  $.ajax({
    type: 'GET',
    beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
    url: '/movies?page=' + page,
    dataType: 'json',
    success: function(data) {
      data.forEach(function(movie) {
        $('#movies-list').append(renderMovie(movie));
      });
    },
    error: function(xhr, status, err) {
      alert('Your movie list could not be loaded. Please try again later.')
    }
  });
}

function renderMovie(movie) {
  source = movie_source(movie.backdrop_path)
  return(
    "<div class='col-xs-6 col-md-3 text-center'>" +
        "<img class='img img-thumbnail' src=" + source + " title=" + movie.title + "/>" +
    "</div>"
  );
}

function movie_source(path) {
  if(path) {
    return "https://image.tmdb.org/t/p/w500" + path;
  } else {
    return "https://image.tmdb.org/t/p/w500/z2QUexmccqrvw1kDMw3R8TxAh5E.jpg"; // Default image as some images are not available
  }
}

$(document).ready(function() {
  var page = 1
  moviesList(page);

  $('#next').click(function() {
    page += 1;
    moviesList(page);
  });
});