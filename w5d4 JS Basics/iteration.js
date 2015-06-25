//bubbleSort
Array.prototype.bubbleSort = function () {
  var output = this.slice(0);
  var unsorted = true;
  while (unsorted) {
    unsorted = false;
    for(var i = 0; i < output.length - 1; i++) {
        if(output[i] > output[i + 1]) {
          var temp = output[i + 1];
          output[i + 1] = output[i];
          output[i] = temp;
          unsorted = true;
        }
    }
  }
  console.log(output);
  return output;
};

[5,4,3,2,1].bubbleSort();

//substrings str => ary
String.prototype.substrings = function () {
  var output = [];
  for(var i = 0; i < this.length; i++) {
    for(var j = i+1; j <= this.length; j++) {
        output.push(this.slice(i, j));
    }
  }
  console.log(output);
  return output;
};

"cat".substrings();
