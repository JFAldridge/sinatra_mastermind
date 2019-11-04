
const gameOngoing = !document.querySelector('#game-result');

console.log(gameOngoing);

if (!gameOngoing) {
  document.querySelector("#submit-button").disabled = true;
}

const newGameButton = document.querySelector('#new-game-button');
const playAgainButton = document.querySelector('#play-again'
);


const rotators = document.querySelectorAll('.rotators');
const rotatorsArr = Array.from(rotators);

const inputs = document.querySelectorAll('.inputs');
const inputsArr = Array.from(inputs);

const colors = ['red', 'blue', 'green', 'orange', 'pink', 'yellow', 'white', 'black']

function shiftColorIndex(i) {
  let currentColorIndex = colors.findIndex( color => color === inputsArr[i].value);
  
  if (currentColorIndex === 7) {
    return 0
  } else {
    return currentColorIndex += 1
  }
}

function rotateColorSelection(i, rotator) {
  const input = inputsArr[i];
  const currentColor = input.value;
  const newColor = colors[shiftColorIndex(i)]
  
  input.value = newColor;
  
  rotator.classList.remove(currentColor);
  rotator.classList.add(newColor);
}


rotatorsArr.map((rotator, i) => {
  rotator.addEventListener('click', function(e) {
    if (gameOngoing) {
      rotateColorSelection(i, e.target);
    };
    
  })
})


newGameButton.addEventListener('click', function() {
  inputsArr[0].value = 'new_game'
  document.querySelector('#code-guess').submit();
})

if (playAgainButton) {
  playAgainButton.addEventListener('click', function() {
    newGameButton.click();
  })
}