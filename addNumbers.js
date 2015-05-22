var readline = require('readline');
var reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

var addNumbers = function (sum, numsLeft, completionCallback) {
  if (numsLeft > 0) {
    reader.question("Enter number: ", function(answer1) {
      var num1 = parseInt(answer1);
      sum += num1;
      numsLeft--;
      console.log(sum);
      addNumbers(sum, numsLeft, completionCallback);
    });
  } else {
    completionCallback(sum);
    reader.close();
  }
};


addNumbers(0, 1, function (sum) {
  console.log("Total Sum: " + sum);
});






//
// var readline = require('readline');
// var reader = readline.createInterface({
//   input: process.stdin,
//   output: process.stdout
// });
//
// function addTwoNumbers (callback) {
//   // Notice how nowhere do I return anything here! You never return in
//   // async code. Since the caller will not wait for the result, you
//   // can't return anything to them.
//
//   reader.question("Enter #1", function (numString1) {
//     reader.question("Enter #2", function (numString2) {
//       var num1 = parseInt(numString1);
//       var num2 = parseInt(numString2);
//
//       callback(num1 + num2);
//     });
//   });
// }
//
// addTwoNumbers(function (result) {
//   console.log("The result is: " + result);
//   reader.close();
// });
