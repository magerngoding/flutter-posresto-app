import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/datasource/auth_local_datasource.dart';
import '../../../data/models/response/auth_response_mode.dart';
import '../../auth/bloc/logout/logout_bloc.dart';
import '../../auth/login_page.dart';

class LogoutPage extends StatefulWidget {
  const LogoutPage({super.key});

  @override
  State<LogoutPage> createState() => _LogoutPageState();
}

class _LogoutPageState extends State<LogoutPage> {
  User? user;

  @override
  void initState() {
    AuthLocalDatasource().getAuthData().then((value) {
      setState(() {
        user = value.user;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body: Center(
        child: Column(
          children: [
            Text('Wellcome to Dashboard'),
            Text('Name : ${user?.name ?? ''}'),
            const SizedBox(
              height: 120.0,
            ),
            BlocListener<LogoutBloc, LogoutState>(
              listener: (context, state) {
                state.maybeWhen(
                  orElse: () {},
                  error: (message) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(message),
                      ),
                    );
                  },
                  success: () {
                    AuthLocalDatasource().remoteAuthData();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Logout Success'),
                        backgroundColor: Colors.green,
                      ),
                    );
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginPage(),
                      ),
                    );
                  },
                );
              },
              child: ElevatedButton(
                onPressed: () {
                  context.read<LogoutBloc>().add(LogoutEvent.logout());
                },
                child: Text('Logout'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
