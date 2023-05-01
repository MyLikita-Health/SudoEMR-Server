module.exports = (io, socket) => {
	
	const newNotification = (data) => {
	    console.log(data.title, data.message);

	    io.sockets.emit("show_notification", {
	      title: data.title,
	      message: data.message,
	      icon: data.icon,
	    });
	  
	}

	const updatePendingLabList = data => {
		io.socket.emit('update_pending_lab_list', {
			priority: 'urgent'
		})
	}

	socket.on("new_notification", newNotification)
	socket.on('update_pending_lab_list', updatePendingLabList)
}