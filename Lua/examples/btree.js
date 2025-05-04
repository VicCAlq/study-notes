const b_tree = [4, 2, 3, 7, 9, 1, 6];
const output = [4, 3, 2, 6, 1, 9, 7];

function split(arr) {
  const copy = Array.from(arr);
  let counter = 0;
  let nodeLevel = 1;
  let splits = [];

  function splitPush(arr) {
    while (arr.length > 0) {
      const nodeSplit = [];
      while (counter !== nodeLevel) {
        nodeSplit.push(arr.shift());
        counter += 1;
      }
      nodeLevel *= 2;
      splits.push(nodeSplit);
      counter = 0;
    }
  } 

  splitPush(arr);

  for (let array of splits) {
    array.reverse();
  }

  splits = splits.flat();
  console.log("Original array => ", copy.toString());
  console.log("Reversed array => ", splits.toString());

  return splits;
}

console.log(output.toString() === split(b_tree).toString());

