// range

var range = function (start, end) {
  if(start === end){
    return [end];
  }
  else {
    return [start].concat(range(start + 1, end)) ;
  }
};

//exponent
function exponent (base, power) {
  if (power === 0 ) {
    return 1;
  }
  else {
    return base * exponent(base, power - 1);
  }
}

//fibbonacci
var fibbonacci = function (n) {
  if(n===1){
    return [0];
  }
  else if (n===2) {
    return [0,1];
  }
  else {
    var sequence = fibbonacci(n - 1);
    var lastNum = sequence[sequence.length - 1];
    var secondLastNum = sequence[sequence.length - 2];
    sequence.push(lastNum + secondLastNum);
    return sequence;
  }
};

//binarySearch-
function bsearch (array, target) {
  if(array.length === 0) { return null; }
  var median = array.length/2;
  median = Math.floor(median);
  if (array[median] === target) {
    return median;
  }
  else if (array[median] > target){
    return bsearch(array.slice(0, median), target);
  }
  else if (array[median] < target) {
    var binary = bsearch(array.slice(median + 1, array.length), target);
    if (binary === null) {
      return null;
    }
    return median + 1 + binary;
  }
}

//makeChange

//mergeSort
var mergeSort = function (array) {
  if(array.length < 2) {
    return array;
  } else {
  var middle = Math.floor(array.length / 2);

  var leftSide = mergeSort(array.slice(0, middle));
  var rightSide = mergeSort(array.slice(middle));

  return merge(leftSide, rightSide);
  }
};

var merge = function (arrayOne, arrayTwo) {
  var output = [];

  while (arrayOne.length > 0 && arrayTwo.length > 0) {
    if (arrayOne[0] < arrayTwo[0]) {
      output.push(arrayOne.shift());
    }
    else {
      output.push(arrayTwo.shift());
    }
  }
  return output.concat(arrayOne, arrayTwo);
};

//subsets
