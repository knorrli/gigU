r_bern = Region.find_or_create_by(name: 'Bern')
r_luzern = Region.find_or_create_by(name: 'Luzern')
r_freiburg = Region.find_or_create_by(name: 'Freiburg')

c_bern = City.find_or_create_by(name: 'Bern', region: r_bern)
c_thun = City.find_or_create_by(name: 'Thun', region: r_bern)
c_luzern = City.find_or_create_by(name: 'Luzern', region: r_luzern)
c_duedingen = City.find_or_create_by(name: 'Düdingen', region: r_freiburg)

Location.find_or_initialize_by(name: 'Bonsoir').update_attributes(
  street: 'Aarbergergasse 33-35',
  zip: '3011',
  city: c_bern,
  region: r_bern,
  events_url: 'https://bonsoir.ch/agenda/'
)

Location.find_or_initialize_by(name: 'Turnhalle').update_attributes(
  street: 'Speichergasse 4',
  zip: '3011',
  city: c_bern,
  region: r_bern,
  events_url: 'https://www.turnhalle.ch/'
)
Location.find_or_initialize_by(name: 'ISC').update_attributes(
  street: 'Neubrückstrasse 10',
  zip: '3012',
  city: c_bern,
  region: r_bern,
  events_url: 'https://isc-club.ch/'
)
Location.find_or_initialize_by(name: 'Bad Bonn').update_attributes(
  street: 'Bonn 2',
  zip: '3186',
  city: c_duedingen,
  region: r_freiburg,
  events_url: 'http://club.badbonn.ch/konzerte'
)

Location.find_or_initialize_by(name: 'Bierhübeli').update_attributes(
  street: 'Neubrückstrasse 43',
  zip: '3012',
  city: c_bern,
  region: r_bern,
  events_url: 'http://www.bierhuebeli.ch/veranstaltungen/'
)

Location.find_or_initialize_by(name: 'Schüür').update_attributes(
  street: 'Tribschenstrasse 1',
  zip: '6005',
  city: c_luzern,
  region: r_luzern,
  events_url: 'http://www.schuur.ch/programm/'
)

Location.find_or_initialize_by(name: 'Mokka').update_attributes(
  street: 'Allmendstrasse 14',
  zip: '3600',
  city: c_thun,
  region: r_bern,
  events_url: 'http://mokka.ch/programm/'
)
