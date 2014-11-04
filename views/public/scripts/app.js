function Repair(data) {
	this.id = ko.observable(data.id);
	this.sro = ko.observable(data.sro);
	this.waiting_on_tech = ko.observable(data.waiting_on_tech);
	this.technician = ko.observable(data.technician);
	this.updated_at = ko.observable(data.updated_at);
}

function RepairViewModel() {
	var _this = this;
	_this.repairs = ko.observableArray([]);
	$.getJSON('/repairs', function(raw) {
		var repairs = $.map(raw, function(item) {
			return new Repair(item);
		});
		_this.repairs(repairs);
	});

	_this.newRepairSro = ko.observable();

	_this.addRepair = function() {
		var newRepair = new Repair({
			sro: _this.newRepairSro,
		});
		_this.tasks.push(newRepair);
		_this.saveRepair(newRepair);
		_this.newRepairSro("");
	};

	_this.saveRepair = function(repair) {
		var repairJSON = ko.toJS(repair);
		$.ajax({
			url: 'http://localhost:8888/repairs/new'
			type: 'POST',
			data: repairJSON
		}).done(function(data){
			repair.id(data.repair.id);
		})
	}
}

ko.applyBindings(new RepairViewModel());