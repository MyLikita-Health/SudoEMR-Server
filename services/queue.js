module.exports = (io, socket) => {
	
	const updateQueue = (data) => {
	    // console.log(data, '========================u');

	    io.sockets.emit("refresh_queue", data);	  
	}

    const updateRegistration = data => {
        io.sockets.emit('new_cashier_approval', data)
    }

	socket.on("update_queue", updateQueue)
    socket.on('update_registration', updateRegistration)
}