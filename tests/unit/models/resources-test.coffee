`import { moduleForModel, test } from 'ember-qunit'`

moduleForModel 'resources', 'Unit | Model | resources', {
  # Specify the other units that are required for this test.
  needs: ['model:hex']
}

test 'it exists', (assert) ->
  model = @subject()
  # store = @store()
  assert.ok !!model
