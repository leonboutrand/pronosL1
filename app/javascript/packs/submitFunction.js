const submitFunction = () => {
  if (document.querySelector('#submit-bets')) {
    document.querySelector('#submit-bets').addEventListener('click', (event) => {
      document.querySelectorAll('.new_bet .bet-submit').forEach((submitBtn) => {
        submitBtn.click();
      });
    });
  }
}

export default submitFunction;
