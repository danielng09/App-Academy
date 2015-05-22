//myEach
Array.prototype.myEach = function(action) {
  for(var i = 0; i < this.length; i++) {
      action(this[i]);
  }
};

// [1,2,3].myEach(printAddOne);

var addOne = function (el) {
  return (el + 1);
};

//myMap

Array.prototype.myMap = function (action) {
  var output = [];
  this.myEach( function (el) {
                output.push(action(el));
              } );

  return output;
};

console.log([1,2,3].myMap(addOne));
// console.log(printAddOne(1));

// myInject

Array.prototype.myInject = function (action) {
  var accumulator = this[0];
  this.slice(1).myEach( function (el) {
        accumulator = action(accumulator, el); }
      );
    return accumulator;
};

console.log(
[1, 2, 3, 4, 5].myInject( function (acc, el) {
                              return acc + el; } )
);
