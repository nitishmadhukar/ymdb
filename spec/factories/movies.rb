FactoryGirl.define do
  factory :movie do
    adult false
    backdrop_path "/fCayJrkfRaCRCTh8GqN30f8oyQF.jpg"
    budget 63000000
    genres [
      {
        "id": 18,
        "name": "Drama"
      }
    ]
    homepage ""
    tmdb_id 550
    original_language "en"
    original_title "Fight Club"
    overview "A ticking-time-bomb insomniac and a slippery soap salesman channel primal male aggression into a shocking new form of therapy. Their concept catches on, with underground \"fight clubs\" forming in every town, until an eccentric gets in the way and ignites an out-of-control spiral toward oblivion."
    popularity 0.5
    poster_path ""
    production_companies [
      {
        "name": "20th Century Fox",
        "id": 25
      }
    ]
    production_countries [
      {
        "iso_3166_1": "US",
        "name": "United States of America"
      }
    ]
    release_date "1999-10-12".to_date
    revenue 100853753
    runtime 139
    spoken_languages [
      {
        "iso_639_1": "en",
        "name": "English"
      }
    ]
    status "Released"
    tagline "How much can you know about yourself if you've never been in a fight?"
    title "Fight Club"
    video false
    vote_average 7.8
    vote_count 3439
  end
end
