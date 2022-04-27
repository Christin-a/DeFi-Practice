import { dbank } from "../../declarations/dbank"; // exposes motoko code to Javascript

window.addEventListener("load", async function() { // once the page loads, the window executes the update function asynchronously
  // console.log("Finished loading");
  update();
});

document.querySelector("form").addEventListener("submit", async function(event) {//creates a function when the form is submitted
  event.preventDefault(); // keeps form from reloading
  // console.log("Submitted.");

  const button = event.target.querySelector("#submit-btn");

  const inputAmount = parseFloat(document.getElementById("input-amount").value); //stores the user input amount in the input amount and parses it into a floating point number
  const outputAmount = parseFloat(document.getElementById("withdrawal-amount").value); //stores the user withdraw amount in the input amount

  button.setAttribute("disabled", true);

  if (document.getElementById("input-amount").value.length != 0) { //only tops up when user types into the top up input area
    await dbank.topUp(inputAmount);
  }

  if (document.getElementById("withdrawal-amount").value.length != 0) { //only withdraws when user types into the top up input area
    await dbank.withdraw(outputAmount);
  }

  await dbank.compound();

  update()

  document.getElementById("input-amount").value = "";
  document.getElementById("withdrawal-amount").value = "";

  button.removeAttribute("disabled");  //disables button after user hits submit

});

async function update() {
  const currentAmount = await dbank.checkBalance(); // wait for the the checkBalance function
  document.getElementById("value").innerText = Math.round(currentAmount * 100) / 100;
};