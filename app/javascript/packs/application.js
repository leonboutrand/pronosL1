import "bootstrap";
import commentsScroller from './commentsScroller.js'

commentsScroller();

document.querySelector('#submit-bets').addEventListener('click', (event) => {
  console.log('yes1')
  document.querySelectorAll('.new_bet .bet-submit').forEach((submitBtn) => {
  console.log('yes2')
    submitBtn.click();
  })
}
)
