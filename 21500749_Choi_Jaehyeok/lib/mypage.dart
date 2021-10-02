import 'package:flutter/services.dart';
import 'package:rive/rive.dart';
import 'package:flutter/material.dart';
import 'detail.dart';
import 'my-globals.dart' as globals;
import 'model/product.dart';
import 'model/products_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';


double wid;
double hei;

class MyPage extends StatefulWidget {


  @override
  _MyPageState createState()=>_MyPageState();
}



class _MyPageState extends State<MyPage> {

  final riveFileName = 'images/Day.riv';
  bool isDarkModeEnabled = false;
  bool b = false;
  Artboard _artboard;



  SimpleAnimation _idle_animation, _day_night_animation, _night_day_animation;

  @override
  void initState() {
    _loadRiveFile();
    super.initState();
    //int pp = ColorDefinition.of(context).p;
    _idle_animation = SimpleAnimation('idle');
    _day_night_animation = SimpleAnimation('day_night');
    _night_day_animation = SimpleAnimation('night_day');

  }

  // loads a Rive file
  void _loadRiveFile() async {
    final bytes = await rootBundle.load(riveFileName);
    final file = RiveFile.import(bytes);
    // Select an animation by its name
    if (file != null) {
      setState(() =>
      _artboard = file.mainArtboard
        ..addController(
          SimpleAnimation('idle'),
        ));
    }
  }



  void _dton_playAnimation() {
    // Remove the controller if necessary
    _artboard.removeController(_night_day_animation);
    // Add the controller to fire the animation
    _artboard.addController(_day_night_animation);
  }

  void _ntod_playAnimation() {
    // Remove the controller if necessary
    _artboard.removeController(_day_night_animation);
    // Add the controller to fire the animation
    _artboard.addController(_night_day_animation);
  }


  /// Show the rive file, when loaded
  @override
  Widget build(BuildContext context) {

    double width = MediaQuery
        .of(context)
        .size
        .width;
    double height = MediaQuery
        .of(context)
        .size
        .height;
    wid = width;
    hei = height;

    return  Scaffold(



      appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              semanticLabel: 'back',
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Center(
            child: Text('My page'),
          ),
      ),
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[


              Container(
                height: 120,
                width: 120,
                child: ClipOval(
                    child : Align(
                      heightFactor: 0.4,
                      widthFactor: 0.4,
                      child: Rive(
                        artboard: _artboard,
                        fit: BoxFit.contain,
                      ),
                    ),

                ),
              ),

                //flex: 300,


           Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.wb_sunny,
                    color: Colors.yellow,
                  ),
                  Switch(
                    value: isDarkModeEnabled,
                    onChanged: (value) {
                      setState(() {
                        isDarkModeEnabled = value;
                        b= isDarkModeEnabled;
                        print(b);

                      }
                      );
                      if(b == true){
                        _dton_playAnimation();
                      }
                      else{
                        _ntod_playAnimation();
                      }

                    },

                    inactiveThumbColor: Colors.amber,
                    inactiveTrackColor: Colors.yellow,

                    activeTrackColor: Colors.purple,
                    activeColor: Colors.deepPurple,
                  ),
                  Icon(
                    Icons.nightlight_round,
                    color: Colors.purple,
                  )
                ],
              ),


          Column(
            children: [
              Text('JaeHyeok Choi',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),



              Text('21500749'),



              Align(
                alignment: Alignment.centerLeft,
                child: Text('My Favorite Hotel list',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
              ),
            ],
          ),
            Expanded(
              flex: 120,
              child: ExampleParallax() ,
                ),




          ],
        ),


    );
  }
}
class ExampleParallax extends StatefulWidget{

  const ExampleParallax({
    Key key,
  }) : super(key: key);
  _ExampleParallax  createState() => _ExampleParallax();
}

class _ExampleParallax extends State<ExampleParallax> {
  int _count = globals.product.length;
  void _update(int count) {
    setState(() => _count = count);
  }

  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      child: Column(
        children: [
          for (final location in globals.product)
            LocationListItem(
              assetName: location.assetName,
              name: location.name,
              location: location.location,
              id : location.id,
              update : _update,
            ),
        ],
      ),
    );
  }
}


class LocationListItem extends StatefulWidget{
  LocationListItem({
    Key key,
    @required this.assetName,
    @required this.name,
    @required this.location,
    @required this.id,
    @required this.update,
  }) : super(key: key);

  final String assetName;
  final String name;
  final String location;
  final int id;
  final ValueChanged<int> update;

  _LocationListItem createState() => _LocationListItem();
}

class _LocationListItem extends State<LocationListItem> {



  final GlobalKey _backgroundImageKey = GlobalKey();
  final List<Product> products = ProductsRepository.loadProducts();
  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: InkWell(
            child:Stack(
              children: [
                _buildParallaxBackground(context),
                _buildGradient(),
                _buildTitleAndSubtitle(),
              ],
            ),
            onTap:() async{
              final result = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DetailPage(product: products[widget.id] , update: widget.update,))
              );

            },
          ),

        ),
      ),

    );

  }

  Widget _buildParallaxBackground(BuildContext context) {

    return Flow(

      delegate: ParallaxFlowDelegate(
        scrollable: Scrollable.of(context), //!
        listItemContext: context,
        backgroundImageKey: _backgroundImageKey,
      ),
      children: [
        Image.asset(
          widget.assetName,
          key: _backgroundImageKey,
          fit: BoxFit.cover,
        ),

      ],
    );
  }

  Widget _buildGradient() {
    return Positioned.fill(
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: SweepGradient(
            colors: [Colors.transparent, Colors.black.withOpacity(0.1)],
            ////
            stops: [0.6, 0.95],
          ),
        ),
      ),
    );
  }

  Widget _buildTitleAndSubtitle() {
    return Positioned(
      left: 20,
      bottom: 20,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.name,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            widget.location,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}

class ParallaxFlowDelegate extends FlowDelegate {
  ParallaxFlowDelegate({
    @required this.scrollable,
    @required this.listItemContext,
    @required this.backgroundImageKey,
  }) : super(repaint: scrollable.position);

  final ScrollableState scrollable;
  final BuildContext listItemContext;
  final GlobalKey backgroundImageKey;

  @override
  BoxConstraints getConstraintsForChild(int i, BoxConstraints constraints) {
    return BoxConstraints.tightFor(
      width: constraints.maxWidth,
    );
  }

  @override
  void paintChildren(FlowPaintingContext context) {
    // Calculate the position of this list item within the viewport.
    final scrollableBox = scrollable.context.findRenderObject() as RenderBox;
    final listItemBox = listItemContext.findRenderObject() as RenderBox;
    final listItemOffset = listItemBox.localToGlobal(
        listItemBox.size.centerLeft(Offset.zero),
        ancestor: scrollableBox);

    // Determine the percent position of this list item within the
    // scrollable area.
    final viewportDimension = scrollable.position.viewportDimension;
    final scrollFraction =
    (listItemOffset.dy / viewportDimension).clamp(0.0, 1.0);

    // Calculate the vertical alignment of the background
    // based on the scroll percent.
    final verticalAlignment = Alignment(0.0, scrollFraction * 2 - 1);

    // Convert the background alignment into a pixel offset for
    // painting purposes.
    final backgroundSize =
        (backgroundImageKey.currentContext/*!*/.findRenderObject() as RenderBox)
            .size;
    final listItemSize = context.size;
    final childRect =
    verticalAlignment.inscribe(backgroundSize, Offset.zero & listItemSize);

    // Paint the background.
    context.paintChild(
      0,
      transform:
      Transform.translate(offset: Offset(0.0, childRect.top)).transform,
    );
  }

  @override
  bool shouldRepaint(ParallaxFlowDelegate oldDelegate) {
    return scrollable != oldDelegate.scrollable ||
        listItemContext != oldDelegate.listItemContext ||
        backgroundImageKey != oldDelegate.backgroundImageKey;
  }
}

class Parallax extends SingleChildRenderObjectWidget {
  Parallax({
    @required Widget background,
  }) : super(child: background);

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderParallax(scrollable: Scrollable.of(context)/*!*/);
  }

  @override
  void updateRenderObject(
      BuildContext context, covariant RenderParallax renderObject) {
    renderObject.scrollable = Scrollable.of(context)/*!*/;
  }
}
class ParallaxParentData extends ContainerBoxParentData<RenderBox> {}

class RenderParallax extends RenderBox
    with RenderObjectWithChildMixin<RenderBox>, RenderProxyBoxMixin {
  RenderParallax({
    @required ScrollableState scrollable,
  }) : _scrollable = scrollable;

  ScrollableState _scrollable;

  ScrollableState get scrollable => _scrollable;

  set scrollable(ScrollableState value) {
    if (value != _scrollable) {
      if (attached) {
        _scrollable.position.removeListener(markNeedsLayout);
      }
      _scrollable = value;
      if (attached) {
        _scrollable.position.addListener(markNeedsLayout);
      }
    }
  }

  @override
  void attach(covariant PipelineOwner owner) {
    super.attach(owner);
    _scrollable.position.addListener(markNeedsLayout);
  }

  @override
  void detach() {
    _scrollable.position.removeListener(markNeedsLayout);
    super.detach();
  }

  @override
  void setupParentData(covariant RenderObject child) {
    if (child.parentData is! ParallaxParentData) {
      child.parentData = ParallaxParentData();
    }
  }

  @override
  void performLayout() {
    size = constraints.biggest;

    // Force the background to take up all available width
    // and then scale its height based on the image's aspect ratio.
    final background = child/*!*/;
    final backgroundImageConstraints =
    BoxConstraints.tightFor(  width: size.width);
    background.layout(backgroundImageConstraints, parentUsesSize: true);

    // Set the background's local offset, which is zero.
    (background.parentData as ParallaxParentData).offset = Offset.zero;
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    // Get the size of the scrollable area.
    final viewportDimension = scrollable.position.viewportDimension;

    // Calculate the global position of this list item.
    final scrollableBox = scrollable.context.findRenderObject() as RenderBox;
    final backgroundOffset =
    localToGlobal(size.centerLeft(Offset.zero), ancestor: scrollableBox);

    // Determine the percent position of this list item within the
    // scrollable area.
    final scrollFraction =
    (backgroundOffset.dy / viewportDimension).clamp(0.0, 1.0);

    // Calculate the vertical alignment of the background
    // based on the scroll percent.
    final verticalAlignment = Alignment(0.0, scrollFraction * 2- 1);

    // Convert the background alignment into a pixel offset for
    // painting purposes.
    final background = child/*!*/;
    final backgroundSize = background.size;
    final listItemSize = size;
    final childRect =
    verticalAlignment.inscribe(backgroundSize, Offset.zero & listItemSize);

    // Paint the background.
    context.paintChild(
        background,
        (background.parentData as ParallaxParentData).offset +
            offset +
            Offset(0.0, childRect.top));
  }
}





