// uniq
Array.prototype.uniq = function() {
  var result = [];

  this.forEach(function(element, index) {
    if (result.indexOf(element) === -1) {
      result.push(element);
    }
  });
  return result;
};

// console.log([1, 2, 1, 3, 3].uniq());

// twoSum
Array.prototype.twoSum = function() {
  var result = [];

  for(var index1=0; index1 < this.length-1; index1++) {
    for(var index2=index1+1; index2 < this.length; index2++) {
      if(this[index1] + this[index2] === 0) {
        result.push([index1, index2]);
      }
    }
  }

  return result;
};

// console.log([-1, 0, 2, -2, 1].twoSum());

// transpose

Array.prototype.transpose = function() {
  var transposedArray = [];


  for(var rowIndex=0; rowIndex < this.length; rowIndex++) {
    var row = [];
    for(var columnIndex=0; columnIndex < this.length; columnIndex++) {
      row.push(this[columnIndex][rowIndex]);
    }
    transposedArray.push(row);
  }

  return transposedArray;
};

console.log([
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8]
  ].transpose());
