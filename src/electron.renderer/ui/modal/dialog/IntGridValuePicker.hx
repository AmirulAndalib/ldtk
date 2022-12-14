package ui.modal.dialog;

class IntGridValuePicker extends ui.modal.Dialog {
	var ld : data.def.LayerDef;

	public function new(ld:data.def.LayerDef, current=-1, onConfirm:Int->Void, ?onCancel:Void->Void) {
		super();

		this.ld = ld;
		addClass("intGridValuePicker");
		var jList= new J('<ul/>');
		jContent.append(jList);
		for(id in ld.getAllIntGridValues()) {
			var jValue = makeIntGridId(id.value, id.value==current);
			jValue.click(_->{
				onConfirm(id.value);
				close();
			});
			jList.append(jValue);
		}

		addCancel(onCancel);
	}


	function makeIntGridId(id:Int, active:Bool) {
		var jId = new J('<li/>');
		if( active )
			jId.addClass("active");

		if( ld.getIntGridValueDisplayName(id)!=null )
			jId.append(ld.getIntGridValueDisplayName(id));
		else
			jId.append('#$id');

		if( active )
			jId.append(" (current)");

		jId.css({ backgroundColor: ld.getIntGridValueColor(id).toHex() });
		return jId;
	}
}