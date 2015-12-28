`import { moduleFor, test } from 'ember-qunit'`

moduleFor 'route:map-generator', 'Unit | Route | map generator', {
  # Specify the other units that are required for this test.
  # needs: ['controller:foo']
}

test 'it exists', (assert) ->
  route = @subject()
  assert.ok route
