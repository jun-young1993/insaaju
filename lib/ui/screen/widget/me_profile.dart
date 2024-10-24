// me_profile.dart
import 'package:flutter/material.dart';
import 'package:insaaju/domain/entities/info.dart';
import 'package:insaaju/states/me/me_selector.dart';
import 'package:insaaju/states/me/me_state.dart';
import 'package:insaaju/ui/screen/widget/info_list/info_row.dart';
import 'package:insaaju/ui/screen/widget/loading_box.dart';
import 'package:insaaju/ui/screen/widget/text.dart';


class MeProfile extends StatelessWidget {
  final VoidCallback handleMeCreate;
  final Function(Info) handleTapList;

  const MeProfile({
    Key? key,
    required this.handleMeCreate,
    required this.handleTapList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        MeLoadStatusSelector((status) {
          switch (status) {
            case MeLoadStatus.loadIsEmpty:
              return GestureDetector(
                onTap: () {
                  handleMeCreate();
                },
                child: InfoRow(info: EmptyInfo()),
              );
            case MeLoadStatus.loadComplete:
              return MeFindSelector((info) {
                return GestureDetector(
                  onTap: () {
                    handleTapList(info);
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
        }),
      ],
    );
  }

  Widget _buildMeError() {
    return MeErrorSelector((error) {
      return ErrorText(
        text: error.toString(),
      );
    });
  }

  Widget _buildLoad() {
    return LoadingBox(
      direction: LoadingBoxDirection.row,
      betweenTextBoxSize: 15,
      backgroundColor: Colors.white.withOpacity(0.0),
      loadingText: '불러오는 중...',
    );
  }
}