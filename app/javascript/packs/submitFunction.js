const submitFunction = () => {
  document.querySelector('#submit-bets').addEventListener('click', (event) => {
    document.querySelectorAll('.new_bet .bet-submit').forEach((submitBtn) => {
      submitBtn.click();
    });
  });
}

export default submitFunction;
