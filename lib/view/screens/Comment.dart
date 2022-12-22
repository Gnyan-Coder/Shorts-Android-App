import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktok/controller/CommentControler.dart';
import 'package:tiktok/view/widgets/TextInputField.dart';
import 'package:timeago/timeago.dart' as tago;

class CommentScreen extends StatefulWidget {
  final String id;
  const CommentScreen({Key? key,required this.id}) : super(key: key);

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  final TextEditingController _commentController=TextEditingController();
  CommentController commentController=Get.put(CommentController());


  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    commentController.updatePostID(widget.id);
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          width: size.width,
          height: size.height,
          child: Column(
            children: [
                  Expanded(
                    child: Obx((){
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount:commentController.comments.length,
                            itemBuilder: (context,index){
                              final comment=commentController.comments[index];
                            return ListTile(
                              leading: CircleAvatar(
                                backgroundColor: Colors.white,
                                backgroundImage: NetworkImage(comment.profilePic),
                              ),
                              title: Row(
                                children: [
                                  Text(comment.userName,
                                    style: const TextStyle(fontSize: 13,
                                        fontWeight: FontWeight.w600,color: Colors.redAccent),),
                                  const SizedBox(width: 5,),
                                  Expanded(
                                    child: Text(comment.comment, style: const TextStyle(fontSize: 13,
                                        fontWeight: FontWeight.w600,color: Colors.white),),
                                  )
                                ],
                              ),
                              subtitle: Row(
                                children: [
                                  Text(tago.format(DateTime.parse(comment.datePub)), style: const TextStyle(fontSize: 13,
                                      fontWeight: FontWeight.w400,color: Colors.white),),
                                  const SizedBox(width: 5,),
                                  Text("Likes ${comment.likes.length}", style: const TextStyle(fontSize: 13,
                                      fontWeight: FontWeight.w600,color: Colors.white),),
                                ],
                              ),
                              trailing:InkWell(
                                onTap: (){
                                  commentController.likeComment(comment.id);
                                },
                                  child: Icon(Icons.favorite,color:comment.likes.contains(FirebaseAuth.instance.currentUser!.uid)?Colors.pinkAccent:Colors.white,)
                              )
                            );
                        });
                      }
                    ),
                  ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.comment),
                title: TextField(
                  controller: _commentController,
                  textInputAction: TextInputAction.send,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    hintText: "Write your comments",
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                  ),
                ),
                trailing: TextButton(
                  onPressed: (){
                    commentController.postComment(_commentController.text);
                  },
                  child:const Icon(Icons.send),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
