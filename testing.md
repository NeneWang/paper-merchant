

```dart

InkWell(
    onTap: () {
    Navigator.push(
        context,
        MaterialPageRoute(
        builder: (context) => DrawerOpenScreen(),
        ),
    );
    },
    child: Container(
    height: Get.height / 17.82,
    width: Get.width / 8.22,
    decoration: BoxDecoration(
        color: green,
        shape: BoxShape.circle,
    ),
    child: Icon(
        Icons.arrow_forward,
        color: white,
        size: Get.height / 29.71,
    ),
    ),
),
```