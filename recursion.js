// range
// var range = function (start, end) {
//   output = []
//   if(start > end){
//     return [];
//   }
//   else {
//     output.push(start)
//     return output.concat(range(start+1, end));
//   }
// };

var range = function (start, end) {
  if(start === end){
    return [end];
  }
  else {
    return [start].concat(range(start + 1, end)) ;
  }
};
// console.log(range(1,5));

//exponent
function exponent (base, power) {
  if (power === 0 ) {
    return 1;
  }
  else {
    return base * exponent(base, power - 1);
  }
}
// console.log(exponent(5,3));

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
// console.log(fibbonacci(7));

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
// console.log(bsearch([1, 2, 3], 1));
// console.log(bsearch([2, 3, 4, 5], 3));
// console.log(bsearch([2, 4, 6, 8, 10], 6));
// console.log(bsearch([1, 3, 4, 5, 9], 5));
// console.log(bsearch([1, 2, 3, 4, 5, 6], 6));
// console.log(bsearch([1, 2, 3, 4, 5, 6], 0));
// console.log(bsearch([1, 2, 3, 4, 5, 7], 6));

//makeChange

//mergeSort
Array.prototype.mergeSort = function (merge) {
  if(this.length <= 1) {
    return this;
  }
  var middle = Math.floor(this.length/2);
  var leftSide = this.slice(0, middle);
  var rightSide = this.slice(middle+1, this.length);
  return merge(leftSide.mergeSort(merge), rightSide.mergeSort(merge));
};
// arrayOne = [1,3,5] => index 3
// arrayTwo = [2,4,6] => index 2
// output = [1,2,3,4,5]
// output = [1,2,3,4,5,6]

var merge = function (one, two) {
  var output = [];
  var arrayOne = one.slice(0);
  var arrayTwo = two.slice(0);
  var indexOne = 0;
  var indexTwo = 0;

  while (indexOne < arrayOne.length && indexTwo < arrayTwo.length) {
    if (arrayOne[indexOne] < arrayTwo[indexTwo]) {
      output.push(arrayOne.shift());
      indexOne += 1;
    }
    else {
      output.push(arrayTwo.shift());
      indexTwo += 1;
    }
  }
  return output.concat(arrayOne).concat(arrayTwo);
};

console.log([1,7,2,5,0,4].mergeSort(merge));
//subsets
