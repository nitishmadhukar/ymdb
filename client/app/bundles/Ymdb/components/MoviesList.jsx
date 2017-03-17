import React from 'react';
import MuiThemeProvider from 'material-ui/styles/MuiThemeProvider';
import {Card, CardActions, CardHeader, CardMedia, CardTitle, CardText} from 'material-ui/Card';
import FloatingActionButton from 'material-ui/FloatingActionButton';
import ActionFavorite from 'material-ui/svg-icons/action/favorite';
import FontIcon from 'material-ui/FontIcon';

export default class MoviesList extends React.Component {
  state = {
    movies: this.props.movies
  }

  static propTypes = {
    movies: React.PropTypes.array
  }

  movieImageSource = (movie_path) => {
    if(movie_path) {
      return(`https://image.tmdb.org/t/p/w500${movie_path}`);
    } else {
      return('https://image.tmdb.org/t/p/w500/z2QUexmccqrvw1kDMw3R8TxAh5E.jpg');
    }
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
            </Card>
          )}
        </div>
      </MuiThemeProvider>
    );
  }
}
