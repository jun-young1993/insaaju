part of '../home_screen.dart';

class PeopleList extends StatelessWidget {
  final Function(Info) handleTapList;
  final Function(Info) handleRemove;
  final VoidCallback handleMeCreate;
  const PeopleList({
    super.key, 
    required this.handleTapList,
    required this.handleRemove, required this.handleMeCreate
  });

  @override
  Widget build(BuildContext context) {

    return SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _buildMe(),
                const SizedBox(height: 10),
                const Divider(),
                Expanded(child: _buildPeopleList())
              ],
          ),
        )
      );
  }

  Widget _buildMe(){
      return Row(
        children: [
          MeLoadStatusSelector((status){
            print(status);
            switch(status){
              case MeLoadStatus.loadIsEmpty:
                return GestureDetector(
                  onTap: (){
                    handleMeCreate();
                  },
                  child: InfoRow(info: ExtendedInfo())
                );
              case MeLoadStatus.loadComplete:
                return MeFindSelector((info){
                  return GestureDetector(
                    onTap: (){
                      _handlerTapInfo(info);
                    },
                    child: InfoRow(info: info),
                  );
                });
              case MeLoadStatus.loadError:
                return _buildMeError();
              case MeLoadStatus.loadQueue:
              case MeLoadStatus.loadProcessing:
              default:
                return _buildLoad();
            }
          })
        ]
      );
  }

  Widget _buildLoad(){
    return  LoadingBox(
      direction: LoadingBoxDirection.row,
      betweenTextBoxSize: 15,
      backgroundColor: Colors.white.withOpacity(0.0),
      loadingText: '불러오는 중...'
    );
  }



  Widget _buildPeopleList(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CaptionText(
          text: 'LIST',
        ),
        const SizedBox(height: 10),
        Expanded(
          child: ListLoadStatusSelector((status){
            switch(status){
              case ListLoadStatus.loadError:
                return _buildListAllError();
              case ListLoadStatus.loadComplete:
                return _buildListAllSelector();
              default:
                return _buildLoad();
            }
          }),
        )
      ],
    );
  }

  Widget _buildMeError(){
    return MeErrorSelector((error){
      return ErrorText(text: error.toString(),);
    });
  }

  Widget _buildListAllError(){
    return ListErrorSelector((error) {
      return ErrorText(text: error.toString(),);
    });
  }

  Widget _buildListAllSelector(){
    return AllListSelector((infos){
      return ListView.builder(
        shrinkWrap: true,
        itemCount: infos.length,
        itemBuilder: (context, index){
          return Dismissible(
            key: Key(infos[index].toString()), 
            direction: DismissDirection.endToStart,
            background: Container(
              decoration: BoxDecoration(
                borderRadius:  BorderRadius.circular(8),
                color: Colors.red,
              ),
              alignment: Alignment.centerRight,
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Icon(
                Icons.delete,
                color: Colors.white,
              ),
            ),
            confirmDismiss: (direction) async {
              final result = await showDialog(
                context: context,
                builder: (BuildContext context){
                  return AlertDialog(
                    title: Text('삭제'),
                    content: Text('${infos[index].toString()} 을 삭제하시겠습니까?'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: (){ Navigator.of(context).pop(false);},
                        child: Text('취소'),
                      ),
                      TextButton(
                        onPressed: (){ 
                          handleRemove(infos[index]);
                          Navigator.of(context).pop(true);
                        },
                        child: Text('확인'),
                      )
                    ]
                  );
                }
              );
              return result;
            },
            child: GestureDetector(
              onTap: (){
                _handlerTapInfo(infos[index]);
              },
              child: Column(
                children: [
                  InfoRow(info: infos[index], profileSize: 18,),
                  const SizedBox(height: 10)
                ],
              ),
            )
          );
        }
      );
    });
  }

  void _handlerTapInfo(Info info){
    handleTapList(info);
  }



}