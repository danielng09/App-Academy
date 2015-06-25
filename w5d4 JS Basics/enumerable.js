//doubleArray

Array.prototype.doubleArray = function () {
  var output = [];

  this.forEach(function(el) {
    output.push(el * 2);
  });

  return output;
};

console.log([1,2,3,4].doubleArray());

//myEach

Array.prototype.myEach = function(action) {
  for(var i = 0; i < this.length; i++) {
      action(this[i]);
  }

  return this;
};

//myMap

Array.prototype.myMap = function (action) {
  var output = [];
  this.myEach( function (el) {
    output.push(action(el));
  });

  return output;
};

// myInject

Array.prototype.myInject = function (action) {
  var accumulator = this[0];
  this.slice(1).myEach(function (el) {
    accumulator = action(accumulator, el); }
  );
  return accumulator;
};


var accumulator = function(accum, el) {
  return accum + el;
};
// console.log([1,2,3,4,5].myInject(accumulator));
