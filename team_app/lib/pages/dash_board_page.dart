import 'package:flutter/material.dart';
import 'package:icovid/constants/color_constant.dart';
import 'package:icovid/widgets/dashboard_grid.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: iBlueColor,
      appBar: AppBar(
        backgroundColor: Color(0xFF473F97),
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(Icons.person_outline),
          iconSize: 30.0,
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications_none),
            iconSize: 28.0,
            onPressed: () {},
          ),
        ],
      ),
      body: CustomScrollView(
        physics: ClampingScrollPhysics(),
        slivers: [
          _buildHeader(),
          //_buildStatusTabBar(),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            sliver: SliverToBoxAdapter(
              child: DashboardGrid(),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.only(top: 20.0),
          ),
        ],
      ),
    );
  }

  SliverPadding _buildHeader() {
    return SliverPadding(
      padding: EdgeInsets.all(20.0),
      sliver: SliverToBoxAdapter(
        child: Text(
          'Dashboard',
          style: TextStyle(
            color: iWhiteColor,
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  SliverToBoxAdapter _buildRegionToolbar() {
    return SliverToBoxAdapter(
      child: DefaultTabController(
          length: 2,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20.0),
            height: 50.0,
            decoration: BoxDecoration(
                color: Colors.white24,
                borderRadius: BorderRadius.circular(25.0)),
            child: TabBar(
              tabs: [Text('MyCountry'), Text('Global')],
              onTap: (index) {},
            ),
          )),
    );
  }

  SliverPadding _buildStatusTabBar() {
    return SliverPadding(
      padding: EdgeInsets.all(20.0),
      sliver: SliverToBoxAdapter(
        child: DefaultTabController(
          length: 3,
          child: TabBar(
            indicatorColor: Colors.transparent,
            labelStyle: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
            ),
            labelColor: iWhiteColor,
            unselectedLabelColor: Colors.white60,
            tabs: [
              Text('รวม'),
              Text('วันนี้'),
              Text('เมื่อวาน'),
            ],
            onTap: (index) {},
          )
        ),
      ),
    );
  }
}
