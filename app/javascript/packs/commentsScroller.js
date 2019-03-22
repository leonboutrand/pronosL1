const commentsScroller = () => {
  const commentsList = document.querySelector('#comments-list');
  if (commentsList) {
    commentsList.scrollTop = commentsList.scrollHeight;
  }
}

export default commentsScroller;
