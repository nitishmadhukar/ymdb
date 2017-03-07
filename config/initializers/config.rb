info = YAML.load(
  ERB.new(
    IO.read(
      File.join(
        Rails.root,
        'config',
        'config.yml'
      )
    )
  ).result
).deep_symbolize_keys!

app_env = info[Rails.env.to_sym]
TMDB_INFO = app_env[:tmdb]
