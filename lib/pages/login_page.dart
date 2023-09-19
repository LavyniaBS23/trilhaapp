import 'package:flutter/material.dart';
import 'package:trilhaapp/pages/main_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController(text: "");
  var senhaController = TextEditingController(text: "");
  bool isObscureText = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      body: SingleChildScrollView(
        //width: double.infinity,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 50),
              Row(
                children: [
                  Expanded(child: Container()),
                  Expanded(
                    flex: 5,
                    child: Image.network(
                      'https://escolhaideal.org/wp-content/uploads/2023/01/1644436653-768x400.jpg',
                    ),
                  ),
                  Expanded(child: Container()),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                'Já tem cadastro?',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Faça seu login e make the change...',
                style: TextStyle(fontSize: 14, color: Colors.white),
              ),
              const SizedBox(height: 40),
              Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 30),
                //color: Colors.green,
                height: 30,
                alignment: Alignment.center,
                child:  TextField(
                  controller: emailController,
                  /*onChanged: (value){
                    email = value;
                  },*/
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.only(top: 5),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color.fromARGB(255, 189, 63, 243))
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color.fromARGB(255, 189, 63, 243))
                    ),
                    hintText: "Email",
                    hintStyle: TextStyle(color: Colors.white),
                    prefixIcon: Icon(Icons.person, color:  Color.fromARGB(255, 189, 63, 243))
                  ),
                )
              ),
              const SizedBox(height: 15),
              Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 30),
                //color: Colors.green,
                height: 30,
                alignment: Alignment.center,
                child:TextField(
                  obscureText: isObscureText,
                  /*onChanged: (value){
                    senha = value;
                  },*/
                  controller: senhaController,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                  decoration:  InputDecoration(
                    contentPadding: const EdgeInsets.only(top: 5),
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Color.fromARGB(255, 189, 63, 243))
                    ),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Color.fromARGB(255, 189, 63, 243))
                    ),
                    hintText: "Senha",
                    hintStyle: const TextStyle(color: Colors.white),
                    prefixIcon: const Icon(
                      Icons.lock,
                      color: Color.fromARGB(255, 189, 63, 243)
                    ),
                    suffixIcon:
                    InkWell(
                      onTap: () {
                          setState(() {
                            isObscureText = !isObscureText;
                          });
                        },
                      child: Icon(
                        isObscureText ? Icons.visibility_off : Icons.visibility, color: const Color.fromARGB(255, 189, 63, 243)),
                    ),
                   /* GestureDetector(
                      onTap: () {
                          setState(() {
                            isObscureText = !isObscureText;
                          });
                        },
                      child: Icon(
                        isObscureText ? Icons.visibility_off : Icons.visibility, color: const Color.fromARGB(255, 189, 63, 243)),
                    ),*/ 
                  ),
                )
              ),
              const SizedBox(height: 30),
              Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(horizontal: 30),
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: double.infinity,
                    child: TextButton(
                        onPressed: () {
                          if(emailController.text.trim() == "email@email.com" && senhaController.text.trim() == "123"){
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MainPage()));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              content: Text("Erro ao efetuar o login")));
                          }
                        },
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)
                            )
                          ),
                          backgroundColor: MaterialStateProperty.all(
                            const Color.fromARGB(255, 189, 63, 243)),
                        ),
                        child: const Text(
                          "ENTRAR",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        )),
                  )),
              Expanded(child: Container()),
              const SizedBox(height: 20),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 30),
                height: 30,
                alignment: Alignment.center,
                child: const Text("Esqueci minha senha",
                    style: TextStyle(
                      color: Colors.yellow,
                      fontWeight: FontWeight.w400,
                    )),
              ),
              //const SizedBox(height: 20),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 30),
                height: 30,
                alignment: Alignment.center,
                child: const Text("Criar conta",
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.w400,
                    )),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    ));
  }
}
