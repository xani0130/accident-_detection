import 'package:flutter/material.dart';

class CustomizedTextField extends StatefulWidget {


  final TextEditingController? myController;
  final String? hintText;
  final bool? isPassword;
  final String? labelText;
  final String? obscuretext;

  const CustomizedTextField({this.myController,this.hintText,this.isPassword,this.labelText,this.obscuretext});

  @override
  State<CustomizedTextField> createState() => _CustomizedTextFieldState();
}

class _CustomizedTextFieldState extends State<CustomizedTextField> {
  bool _isSecurePass = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.symmetric(horizontal: 40),
      child: TextField(
        style: TextStyle(color: Colors.white),
        keyboardType: widget.isPassword!
            ?TextInputType.visiblePassword
            :TextInputType.emailAddress,
        enableSuggestions: widget.isPassword!? false : true,
        autocorrect: widget.isPassword!? false:true,
        obscureText:_isSecurePass,
        controller: widget.myController,
        decoration: InputDecoration(
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            labelText: widget.hintText,
            labelStyle: TextStyle(
              color: Colors.white, //<-- SEE HERE
            ),
            suffixIcon:togglePassword()

        ),

      ),
    );
  }
  Widget togglePassword(){
    return IconButton(
      onPressed: (){
        setState(() {
          _isSecurePass = !_isSecurePass;
        });
      },
      icon: _isSecurePass? Icon(Icons.visibility_off):
      Icon( Icons.visibility),
      color: Colors.white,
    );
  }
}
class CustomizedTextfield extends StatefulWidget {


  final TextEditingController? myController;
  final String? hintText;
  final bool? isPassword;
  final String? labelText;

  const CustomizedTextfield({this.myController,this.hintText,this.isPassword,this.labelText,});

  @override
  State<CustomizedTextfield> createState() => _CustomizedTextfieldState();
}

class _CustomizedTextfieldState extends State<CustomizedTextfield> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.symmetric(horizontal: 40),
      child: TextField(

        style: TextStyle(color: Colors.white),
        keyboardType: widget.isPassword!
            ?TextInputType.visiblePassword
            :TextInputType.emailAddress,
        enableSuggestions: widget.isPassword!? false : true,
        autocorrect: widget.isPassword!? false:true,
        controller: widget.myController,
        decoration: InputDecoration(
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          labelText: widget.hintText,labelStyle: TextStyle(

          color: Colors.white,
        ),
        ),

      ),
    );
  }

}


