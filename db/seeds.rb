Location.find_or_initialize_by(name: 'Bonsoir').update_attributes(
  street: 'Aarbergergasse 33-35',
  zip: '3011',
  city: 'Bern',
  region: 'Bern',
  events_url: 'https://bonsoir.ch/agenda/'
)

Location.find_or_initialize_by(name: 'Turnhalle').update_attributes(
  street: 'Speichergasse 4',
  zip: '3011',
  city: 'Bern',
  region: 'Bern',
  events_url: 'https://www.turnhalle.ch/'
)
Location.find_or_initialize_by(name: 'ISC').update_attributes(
  street: 'Neubrückstrasse 10',
  zip: '3012',
  city: 'Bern',
  region: 'Bern',
  events_url: 'https://isc-club.ch/'
)
Location.find_or_initialize_by(name: 'Bad Bonn').update_attributes(
  street: 'Bonn 2',
  zip: '3186',
  city: 'Düdingen',
  region: 'Fribourg',
  events_url: 'http://club.badbonn.ch/konzerte'
)

Location.find_or_initialize_by(name: 'Bierhübeli').update_attributes(
  street: 'Neubrückstrasse 43',
  zip: '3012',
  city: 'Bern',
  region: 'Bern',
  events_url: 'http://www.bierhuebeli.ch/veranstaltungen/'
)

Location.find_or_initialize_by(name: 'Schüür').update_attributes(
  street: 'Tribschenstrasse 1',
  zip: '6005',
  city: 'Luzern',
  region: 'Luzern',
  events_url: 'http://www.schuur.ch/programm/'
)
