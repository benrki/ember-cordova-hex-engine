`import DS from 'ember-data'`

Hex = DS.Model.extend {
  resources: DS.belongsTo 'resources'
}

`export default Hex`
