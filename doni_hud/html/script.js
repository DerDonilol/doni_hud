
/* -------------------------- Einstellungen  -------------------------- */
var server_slots = "64";
var check_interval = 100;
/* Nicht Ändern!!!!!!!!!!!!!!!!!!!!!!!!! */
var announced = false;
var displayed = false;
/* ----------------------------------------------------------------- */

//////////////// JOBANZEIGE TEST /////////////////

window.addEventListener('message', function (event) {
  const data = event.data;

  switch (data.action) {
      case 'showJob':
          document.getElementById('jobInfo').innerText = data.job;
          document.getElementById('hudContainer').style.display = 'block';
          break;

      case 'showBlackMoney':
          const blackMoneyElem = document.getElementById('blackMoneyDisplay');
          blackMoneyElem.innerText = 'Black Money: $' + data.amount;
          blackMoneyElem.style.display = 'block';
          break;

      case 'hideBlackMoney':
          document.getElementById('blackMoneyDisplay').style.display = 'none';
          break;

      case 'updateWalletMoney':
          document.getElementById('walletAmount').innerText = data.wallet;
          break;

      case 'updateBankMoney':
          document.getElementById('bankAmount').innerText = data.bank;
          break;

      case 'updatePlayerCount':
          document.getElementById('playerCount').innerText = data.count;
          break;

      case 'updatePlayerId':
          document.getElementById('playerId').innerText = data.playerId;
          break;

      case 'updateSpeedo':
          const speedometer = document.getElementById("speedometer");
          if (data.show) {
              speedometer.classList.remove("hidden");

              const speed = data.speed || 0;
              const maxSpeed = 240;
              const offset = 283 - (283 * speed / maxSpeed);
              document.getElementById("speedProgress").style.strokeDashoffset = offset;

              document.getElementById("speed").textContent = speed;
              document.getElementById("fuelVal").textContent = data.fuel;
          } else {
              speedometer.classList.add("hidden");
          }
          break;
  }
});


function updateBlackMoney(amount) {
  const blackMoneyElem = document.getElementById('blackMoneyDisplay');
  blackMoneyElem.innerText = 'Black Money: $' + amount;
  blackMoneyElem.style.display = 'block';
}

function hideBlackMoney() {
  document.getElementById('blackMoneyDisplay').style.display = 'none';
}


window.addEventListener('message', function(event) {
  let data = event.data;

  if (data.action === 'updateWalletMoney') {
      document.getElementById('walletAmount').innerText = data.wallet;
  }
});



window.addEventListener('message', function(event) {
  let data = event.data;

  if (data.action === 'updateWalletMoney') {
      document.getElementById('walletAmount').innerText = data.wallet;
  }
});

window.addEventListener('message', function(event) {
  let data = event.data;

  if (data.action === 'updateBankMoney') {
      document.getElementById('bankAmount').innerText = data.bank;
  }
});

window.addEventListener('message', function(event) {
  let data = event.data;

  if (data.action === 'updatePlayerCount') {
      document.getElementById('playerCount').innerText = data.count;
  }
});

window.addEventListener('message', function(event) {
  let data = event.data;

  if (data.action === 'updatePlayerId') {
      document.getElementById('playerId').innerText = data.playerId;
  }
});