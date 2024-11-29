import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';
import 'package:network_connectivity_management/Bloc/Post/data/model/post_model.dart';
import 'package:network_connectivity_management/Bloc/Post/data/repository/post_repo.dart';
part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc() : super(PostInitial()) {
    on<PostInitialFetchEvent>(_postInitialFetchEvent);
  }

  Future<void> _postInitialFetchEvent(
      PostInitialFetchEvent event, Emitter<PostState> emit) async {
    emit(PostFechingLoadingState());
    await _fetchPosts(emit);
  }

  Future<void> _fetchPosts(Emitter<PostState> emit) async {
    try {
      List<PostModel> posts = await PostRepo.fetchPost();
      emit(PostFetchingSuccessfulState(posts: posts));
    } on SocketException {
      emit(PostFechingErrorState(
        message: 'No internet connection. Please check your network.',
      ));
    } on TimeoutException {
      emit(PostFechingErrorState(
        message: 'Request timed out. Please try again.',
      ));
    } catch (e) {
      emit(PostFechingErrorState(
        message: 'Something went wrong. Please try again later.',
      ));
    }
  }
}
