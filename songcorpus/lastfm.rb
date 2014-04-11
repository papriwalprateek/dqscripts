require 'lastfm'

lastfm = Lastfm.new('d27dd4135f22beb89d84ad9858be3821','8229f90670328831d63165e9cc710711')

token = lastfm.auth.get_token

lastfm.session = lastfm.auth.get_session(token: token)['key']

toptracks = lastfm.chart.get_top_tracks(:limit=>1000)
