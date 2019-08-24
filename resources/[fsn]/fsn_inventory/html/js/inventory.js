var canUse = true
window.addEventListener("message", function (event) {
	if (event.data.action == 'display') {
		if (event.data.val) {
			$('.ui').show()
			$('#playerInventory').html('')
			$('#otherInventory').html('')
			if (canUse) {
				$('.overlay').hide()	
			} else {
				$('.overlay').show()	
			}
		} else {
			$('.ui').hide()
			$('.overlay').hide()
		}
	}
	if (event.data.action == 'update') {
		if (event.data.inuse) {
			canUse = false
		} else {
			canUse = true
		}
		if ($('.ui').is(":visible")) {
			if (canUse) {
				$('.overlay').hide()	
			} else {
				$('.overlay').show()	
			}
		}
		updateInv('playerInventory', event.data.first)
		updateInv('otherInventory', event.data.second)
	}
	if (event.data.action == 'log') {
		var d = new Date();
		$('.console').prepend('<div class="console_entry">[LUA]['+d.getHours()+':'+d.getMinutes()+':'+d.getSeconds()+'] '+event.data.string+'</div>')
	}
	if (event.data.action == 'data') {
		log('got item data from luas')
		var html = '<h1>'+event.data.name+'</h1>'+
			'<img src="img/items/'+event.data.index+'.png"/>'+
			event.data.html
		$('#iteminfo').html(html)
	}
})

function log(string) {
	var d = new Date();
	$('.console').prepend('<div class="console_entry">[JS]['+d.getHours()+':'+d.getMinutes()+':'+d.getSeconds()+'] '+string+'</div>')
}

function updateInv(div, data) {
	log('got update from lua') 
	$('#'+div).html('')
	var updateString = ''
	if (data.length > 0) {
		for (var key in data){
			var item = data[key]
			if (item.name) {
				updateString = updateString+
					'<div class="slot" data-inventory="'+div+'" data-slotid="'+key+'">'+
						'<div class="item" data-inventory="'+div+'" data-slotid="'+key+'" onclick="viewData(\''+div+'/'+key+'\')">'+
							'<div class="item-icon">'+
								'<img src="img/items/'+item.index+'.png"/>'+
								'<div class="item-amt">'+
									item.amt+
								'</div>'+
							'</div>'+
							'<div class="item-name">'+
								item.name+
							'</div>'+
						'</div>'+
					'</div>'
			} else {
				updateString = updateString +'<div class="slot" data-inventory="'+div+'" data-slotid="'+key+'"></div>'
			}
		}
		$('#'+div).html(updateString)
	}
	init()
}

function viewData(obj) {
	obj = obj.split("/")
	obj[1] = parseInt(obj[1])
	$.post('http://fsn_inventory/viewData', JSON.stringify({
		inv: obj[0],
		slot: obj[1]
	}))
	log('asking lua for info on slot('+obj[1]+') in inv('+obj[0]+')')
}

function init() {
	// this function will make the stuff drag/droppable
	$('.item').each(function(i, obj) {
		$(obj).draggable({
			helper: 'clone',
			appendTo: 'body',
			zIndex: 99999,
			revert: 'invalid',
			start: function (event, ui) {
				$(this).css('background-image', 'none');
			},
			stop: function () {
				itemData = $(this).data("item");
				
				if (itemData !== undefined && itemData.name !== undefined) {
					$(this).css('background-image', 'url(\'img/items/' + itemData.name + '.png\'');
					$("#drop").removeClass("disabled");
					$("#use").removeClass("disabled");
					$("#give").removeClass("disabled");
				}
			}
		});
	});
	$('.slot').droppable({
		drop: function (event, ui) {
			hoverClass: 'hoverControl',
			updateSlot(num, $(this).data("inventory"), $(this).data("slotid"), ui.draggable.data("inventory"), ui.draggable.data("slotid"))	
		}
	});
	$('#drop').droppable({
		drop: function (event, ui) {
			hoverClass: 'hoverControl',
			dropSlot(num, ui.draggable.data("inventory"), ui.draggable.data("slotid"))	
		}
	});
	$('#use').droppable({
		drop: function (event, ui) {
			hoverClass: 'hoverControl',
			useSlot(num, ui.draggable.data("inventory"), ui.draggable.data("slotid"))	
		}
	});
}

function useSlot(amt, fromInv, fromSlot) {
	log('sending: use '+amt+' from '+fromSlot+'/'+fromInv)
	$.post('http://fsn_inventory/useSlot', JSON.stringify({
		amt: amt,
		fromInv: fromInv,
		fromSlot: fromSlot+1
	}));
}

function dropSlot(amt, fromInv, fromSlot) {
	log('sending: drop '+amt+' from '+fromSlot+'/'+fromInv)
	$.post('http://fsn_inventory/dropSlot', JSON.stringify({
		amt: amt,
		fromInv: fromInv,
		fromSlot: fromSlot+1
	}));
}

function updateSlot(amt, toInv, toSlot, fromInv, fromSlot) {
	log('sending: move '+amt+' from '+fromSlot+'/'+fromInv+' to '+toSlot+'/'+toInv)
	$.post('http://fsn_inventory/dragToSlot', JSON.stringify({
		amt: amt,
		fromInv: fromInv,
		fromSlot: fromSlot+1,
		toInv: toInv,
		toSlot: toSlot+1
	}));
}

var num = -99
function numChange(up) {
	if (up) {
		if (num < 1) {
			num = 1
		}
		num = num + 1
		if (num > 10) {
			num = -99
		}
	} else {
		num = num - 1
		if (num < 1) {
			num = -99
		}
	}
	if (num == -99) {
		$('.number').html('ALL')
	} else {
		$('.number').html(num)
	}
}

document.onkeydown = function(evt) {
    evt = evt || window.event;
    if (evt.keyCode == 27 || evt.keyCode == 112) {
        $.post('http://fsn_inventory/closeGUI', JSON.stringify({}))
	}
};