import React from 'react';
import MuiThemeProvider from 'material-ui/styles/MuiThemeProvider';
import {Card, CardActions, CardHeader, CardMedia, CardTitle, CardText} from 'material-ui/Card';
import FloatingActionButton from 'material-ui/FloatingActionButton';
import ActionFavorite from 'material-ui/svg-icons/action/favorite';
import FontIcon from 'material-ui/FontIcon';
import RaisedButton from 'material-ui/RaisedButton';

export default class MoviesList extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      movies: this.props.movies,
      favorites: this.props.favorites,
      favorited_movie_ids: [],
      page: 2
    }
  }

  static propTypes = {
    movies: React.PropTypes.array,
    favorites: React.PropTypes.array
  }

  componentDidMount() {
    this.retrieveFavoritedMovieIds(this.props.favorites);
  }

  movieImageSource = (movie_path) => {
    if(movie_path) {
      return(`https://image.tmdb.org/t/p/w500${movie_path}`);
    } else {
      return('https://image.tmdb.org/t/p/w500/z2QUexmccqrvw1kDMw3R8TxAh5E.jpg');
    }
  }

  toggleFavorites = (movie_id) => {
    var favorited_movie_ids = this.state.favorited_movie_ids;
    if(favorited_movie_ids.indexOf(movie_id) == -1) {
      this.addToFavorites(movie_id);
    } else {
      this.removeFromFavorites(movie_id);
    }
  }

  addToFavorites = (movie_id) => {
    $.ajax({
      url: 'favorites',
      beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
      type: 'POST',
      dataType: 'json',
      data: {movie_id: movie_id},
      success: function(result, status, xhr) {
        if(xhr.status == 201) {
          let favorites = this.addItemToArray(this.state.favorites, result.favorite);
          let favorited_movie_ids = this.addItemToArray(this.state.favorited_movie_ids, result.favorite.movie_id);
          this.setState({
            favorites: favorites,
            favorited_movie_ids: favorited_movie_ids
          });
        } else {
          alert('Movie could not be added to favorites. Try again later.');
        }
      }.bind(this),
      error: function(xhr, status, err) {
        alert('Movie could not be added to favorites. Try again later.');
      }.bind(this)
    });
  }

  removeFromFavorites = (movie_id) => {
    var favorite_id = this.retrieveFavoritedIdByMovieId(movie_id);
    $.ajax({
      url: 'favorites/' + favorite_id,
      beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
      type: 'DELETE',
      dataType: 'json',
      success: function(result, status, xhr) {
        if(xhr.status == 200) {
          let favorites = this.removeItemFromArray(this.state.favorites, this.retrieveFavoriteByFavoritedId(favorite_id));
          let favorited_movie_ids = this.removeItemFromArray(this.state.favorited_movie_ids, movie_id);
          this.setState({
            favorites: favorites,
            favorited_movie_ids: favorited_movie_ids
          });
        } else {
          alert('Movie could not be removed from favorites. Try again later.');
        }
      }.bind(this),
      error: function(xhr, status, err) {
        alert('Movie could not be removed from favorites. Try again later.');
      }.bind(this)
    });
  }

  retrieveFavoritedMovieIds = () => {
    var favorited_movie_ids = [];
    this.state.favorites.map((favorite) => {
      favorited_movie_ids.push(favorite.movie_id);
    });
    this.setState({favorited_movie_ids: favorited_movie_ids});
  }

  retrieveFavoritedIdByMovieId = (movie_id) => {
    var favorite = this.state.favorites.find((favorite) => { return(favorite.movie_id == movie_id) });
    return favorite.id;
  }

  retrieveFavoriteByFavoritedId = (favorite_id) => {
    var favorite = this.state.favorites.find((favorite) => { return(favorite.id == favorite_id) });
    return favorite;
  }

  favorited = (movie_id) => {
    let favorited_movie_ids = this.state.favorited_movie_ids;
    if(favorited_movie_ids.indexOf(movie_id) != -1) {
      return({fill: 'rgb(255, 0, 0)'});
    } else {
      return({fill: 'rgb(255, 255, 255)'});
    }
  }

  addItemToArray = (array_of_items, item) => {
    var new_array_of_items = array_of_items;
    new_array_of_items.push(array_of_items, item);
    return new_array_of_items;
  }

  removeItemFromArray = (array_of_items, item) => {
    var new_array_of_items = array_of_items;
    new_array_of_items.splice(new_array_of_items.indexOf(item), 1);
    return new_array_of_items;
  }

  loadMore = () => {
    var page = this.state.page;
    $.ajax({
      url: 'movies?page=' + page,
      beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
      type: 'GET',
      dataType: 'json',
      success: function(result, status, xhr) {
        if(xhr.status == 200) {
          let movies = this.state.movies
          result.movies.map((movie) => { movies.push(movie) });
          this.setState({
            movies: movies,
            page: page + 1
          });
        } else {
          alert('Movies could not be loaded. Try again later.');
        }
      }.bind(this),
      error: function(xhr, status, err) {
        alert('Movies could not be loaded. Try again later.');
      }.bind(this)
    });
  }

  render() {
    return(
      <MuiThemeProvider>
        <div>
          {this.state.movies.map((movie) =>
            <Card key={movie.id} className='col-xs-6 col-md-4'>
              <CardMedia overlay={<CardTitle title={movie.title} />}>
                <img src={this.movieImageSource(movie.backdrop_path)} />
              </CardMedia>
              <CardActions>
                <FloatingActionButton mini={true}>
                  <ActionFavorite onClick={() => this.toggleFavorites(movie.id)} style={this.favorited(movie.id)} />
                </FloatingActionButton>
              </CardActions>
            </Card>
          )}
          <div className='clearfix'></div>
          <div className='row text-center'>
            <RaisedButton label="Load more..." secondary={true} onClick={this.loadMore} />
          </div>
        </div>
      </MuiThemeProvider>
    );
  }
}
