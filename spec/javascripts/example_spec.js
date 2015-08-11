describe('truncateText', function() {

  it('should exist', function() {
    assert(truncateText);
  });

  it('should return the original word if under 100 characters', function() {
    assert.equal(truncateText('word'), 'word')
  });

});