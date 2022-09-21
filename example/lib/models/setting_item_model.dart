

class SettingItem{

  String title;
  String icon;
   Function(dynamic key) onchange;


  SettingItem(this.title, this.icon, this.onchange);

  factory  SettingItem.radioButton(
      String title,String icon,Function(dynamic key) onchange
      ){
        return SettingItem(title, icon, (key) => null);
  }


  factory SettingItem.clorPicker(String title,String icon,Function(dynamic key) onColorSelected){
    return SettingItem(title, icon, (key) => null);

  }





}


// enum ItemType{
//
// }