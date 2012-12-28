/*!
 * Attach chai to global should
 */

global.chai = require('chai');
chai.should()

/*!
 * Provide check for fail function.
 */

global.err = function (fn, msg) {
  try {
    fn();
    throw new chai.AssertionError({ message: 'Expected an error' });
  } catch (err) {
    chai.expect(err.message).to.equal(msg);
  }
};
