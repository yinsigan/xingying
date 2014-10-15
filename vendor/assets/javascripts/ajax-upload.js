//https://github.com/New-Bamboo/example-ajax-upload
function initFileOnlyAjaxUpload(url, id, name) {
  var image = document.getElementById(id);
  image.onchange = function (evt) {
    var formData = new FormData();

    // Since this is the file only, we send it to a specific location
    var action = url;

    // FormData only has the file
    var fileInput = document.getElementById(id);
    var file = fileInput.files[0];
    formData.append(name, file);

    // Code common to both variants
    sendXHRequest(formData, action);
  }
}

// Once the FormData instance is ready and we know
// where to send the data, the code is the same
// for both variants of this technique
function sendXHRequest(formData, uri) {
  // Get an XMLHttpRequest instance
  var xhr = new XMLHttpRequest();

  // Set up events
  xhr.upload.addEventListener('loadstart', onloadstartHandler, false);
  xhr.upload.addEventListener('progress', onprogressHandler, false);
  xhr.upload.addEventListener('load', onloadHandler, false);
  xhr.addEventListener('readystatechange', onreadystatechangeHandler, false);

  // Set up request
  xhr.open('POST', uri, true);

  // Fire!
  xhr.send(formData);
}

// Handle the start of the transmission
// 开始传输
function onloadstartHandler(evt) {
}

// Handle the end of the transmission
//文件上传，等待应答
function onloadHandler(evt) {
}

// Handle the progress
//上传进度
function onprogressHandler(evt) {
  var progress_div = document.getElementById('progress');
  progress_div.style.display = "block";
  var div = document.getElementById('progress-bar');
  var percent = evt.loaded/evt.total*100;
  div.style.width = percent + '%';
}

// Handle the response from the server
function onreadystatechangeHandler(evt) {
  var status, text, readyState;

  try {
    readyState = evt.target.readyState;
    text = evt.target.responseText;
    status = evt.target.status;
  }
  catch(e) {
    return;
  }

  //正确返回
  if (readyState == 4 && status == '200' && evt.target.responseText) {
    var status = document.getElementById('upload-status');
    status.innerHTML += '<' + 'br>Success!';

    var result = document.getElementById('result');
    result.innerHTML = '<p>The server saw it as:</p><pre>' + evt.target.responseText + '</pre>';
  }
}
