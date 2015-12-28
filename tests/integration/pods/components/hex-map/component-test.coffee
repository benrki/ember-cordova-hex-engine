`import { test, moduleForComponent } from 'ember-qunit'`
`import hbs from 'htmlbars-inline-precompile'`

moduleForComponent 'hex-map', 'Integration | Component | hex map', {
  integration: true
}

test 'it renders', (assert) ->
  assert.expect 2

  # Set any properties with @set 'myProperty', 'value'
  # Handle any actions with @on 'myAction', (val) ->

  @render hbs """{{hex-map}}"""

  assert.equal @$().text().trim(), ''

  # Template block usage:
  @render hbs """
    {{#hex-map}}
      template block text
    {{/hex-map}}
  """

  assert.equal @$().text().trim(), 'template block text'
