Postgrex.Types.define(Crimemap.PostgrexTypes,
              [Geo.PostGIS.Extension] ++ Ecto.Adapters.Postgres.extensions(),
              json: Poison)
