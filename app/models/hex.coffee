`import DS from 'ember-data'`

Hex = DS.Model.extend
  resources:
    hexon: DS.attr 'number'

  position:
    x: DS.attr 'number'
    y: DS.attr 'number'
    z: DS.attr 'number'

`export default Hex`
