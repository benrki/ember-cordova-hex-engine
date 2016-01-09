`import DS from 'ember-data'`

Resources = DS.Model.extend
  hex:   DS.belongsTo 'hex'
  hexon: DS.attr      'number'

`export default Resources`
