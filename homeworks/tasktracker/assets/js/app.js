// Brunch automatically concatenates all files in your
// watched paths. Those paths can be configured at
// config.paths.watched in "brunch-config.js".
//
// However, those files will only be executed if
// explicitly imported. The only exception are files
// in vendor, which are never wrapped in imports and
// therefore are always executed.

// Import dependencies
//
// If you no longer want to use a dependency, remember
// to also remove its path from "config.paths.watched".
import "phoenix_html";
import $ from "jquery";

// Import local files
//
// Local files can be imported directly using relative
// paths "./socket" or full ones "web/static/js/socket".

// import socket from "./socket"

//Reference: https://github.com/luqiwang/CS5610/blob/master/task2/assets/js/app.js

function start(task_id) {
  let text = JSON.stringify({
    timeblock: {
      start_time: new Date(),
      end_time: new Date(0),
      task_id: task_id
    },
  })

  $.ajax(timeblock_path, {
    method: "post",
    dataType: "json",
    contentType: "application/json; charset=UTF-8",
    data: text,
    success: (resp) => { set_button(resp.data.id) },
  });
}

function end(timeblock_id) {
  let text = JSON.stringify({
    timeblock: {
      end_time: new Date()
    },
  })
  $.ajax(timeblock_path + "/" + timeblock_id, {
    method: "put",
    dataType: "json",
    contentType: "application/json; charset=UTF-8",
    data: text,
    success: (resp) => { set_button(resp.data.id) },
  })
}


function set_button(timeblock_id) {
  let btn = $("#start-button")
  if (!btn.data("start")) {
    btn.data("start", true);
    btn.data("timeblock_id", timeblock_id)
  } else {
    btn.data("start", false);
  }
  update_button();
}

function update_button() {
  let btn = $("#start-button")
  if (!btn.data("start")) {
    btn.text("Start Working")
    btn.attr('class', 'btn btn-primary')
    location.reload()
  } else {
    btn.text("Stop Working ")
    btn.attr('class', 'btn btn-warning')
  }
}



window.delete_block = function(timeblock_id) {
  $.ajax(timeblock_path + "/" + timeblock_id, {
    method: "delete",
    dataType: "json",
    contentType: "application/json; charset=UTF-8",
    data: "",
    success: (resp) => { $("#b" + timeblock_id).remove() },
  })
}

window.update_start = function (timeblock_id) {
  let start_val = $("#start-time-input").val();
  let date = new Date(""+start_val)
  let text = JSON.stringify({
    timeblock: {
      start_time: date.getTime() - 1000*60*60*5
    },
  })
  $.ajax(timeblock_path + "/" + timeblock_id, {
    method: "put",
    dataType: "json",
    contentType: "application/json; charset=UTF-8",
    data: text,
    success: (resp) => { location.reload() },
  })
}

window.update_end = function (timeblock_id) {
  let end_val = $("#end-time-input").val();
  let date = new Date(""+end_val)
  let text = JSON.stringify({
    timeblock: {
      end_time: date.getTime() - 1000*60*60*5
    },
  })
  $.ajax(timeblock_path + "/" + timeblock_id, {
    method: "put",
    dataType: "json",
    contentType: "application/json; charset=UTF-8",
    data: text,
    success: (resp) => { location.reload() },
  })
}

function start_click(ev) {
  let btn = $(ev.target);
  if (!btn.data("start")) {
    start(task_id)
  } else {
    end(btn.data("timeblock_id"))
  }
}

window.add_time_block = function () {
  /*
  let start_val = $("#add-start-time").val();
  let end_val = $("#add-end-time").val();
  let startDate = new Date("" + start_val);
  let endDate = new Date("" + end_val);
  if (isNaN(startDate.getTime()) || isNaN(endDate.getTime())) {
    $("#add-time-warnning").css("color", "red")
    $("#add-time-warnning").text("Your input is Invalid, Please follow the rule")
  }
  let text = JSON.stringify({
    timeblock: {
      start_time: startDate.getTime(),
      end_time: endDate.getTime(),
      task_id: task_id
    },
  })

  $.ajax(timeblock_path, {
    method: "post",
    dataType: "json",
    contentType: "application/json; charset=UTF-8",
    data: text,
    success: (resp) => {
      $("#add-start-time").val("")
      $("#add-end-time").val("")
      $("#add-time-warnning").css("color", "green")
      $("#add-time-warnning").text("Success!")
      showBlock(resp.data)
     },
  });
*/
}

function init_start() {
  if (!$('#start-button')) {
    return;
  }
  let rows = $(".block-row")
  for (let i = 0; i < rows.length; i++) {
    let timeblock_id = $(rows[i]).attr('id').substr(1)
    $(rows[i]).append("<td>"
     + "<span><button onclick='edit_start(" + timeblock_id + ")' class='btn btn-warning btn-xs'>Edit Start Time</button>"
     + "<span><button onclick='edit_end(" + timeblock_id + ")' class='btn btn-warning btn-xs'>Edit End Time</button>"
     + "<span><button onclick='delete_block(" + timeblock_id + ")' class='btn btn-danger btn-xs'>Delete</button></span>"
     + "</span></td>")
  }
  $("#start-button").click(start_click);
}

$(init_start)
