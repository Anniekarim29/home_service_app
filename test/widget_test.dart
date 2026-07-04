import 'package:flutter_test/flutter_test.dart';
import 'package:home_service_app/services/user_service.dart';

void main() {
  test('UserService Singleton State & Update Test', () {
    final userService = UserService();

    // Verify initial values
    expect(userService.name, 'Annie Karim');
    expect(userService.email, 'annie@example.com');
    expect(userService.phone, '+1 234 567 8900');

    // Update values
    userService.updateProfile(
      name: 'Jane Doe',
      email: 'jane@example.com',
      phone: '+1 987 654 3210',
    );

    // Verify updated values
    expect(userService.name, 'Jane Doe');
    expect(userService.email, 'jane@example.com');
    expect(userService.phone, '+1 987 654 3210');
    
    // Verify singleton behavior
    final anotherInstance = UserService();
    expect(anotherInstance.name, 'Jane Doe');
  });
}
