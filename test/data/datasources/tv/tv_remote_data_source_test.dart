import 'dart:convert';

import 'package:ditonton/data/datasources/tv/tv_remote_data_source.dart';
import 'package:ditonton/data/models/tv/tv_detail_model.dart';
import 'package:ditonton/data/models/tv/tv_season_detail_model.dart';
import 'package:ditonton/data/models/tv/tv_response.dart';
import 'package:ditonton/common/exception.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

import '../../../json_reader.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  const API_KEY = 'api_key=2174d146bb9c0eab47529b2e77d6b526';
  const BASE_URL = 'https://api.themoviedb.org/3';

  late TvRemoteDataSourceImpl dataSource;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = TvRemoteDataSourceImpl(client: mockHttpClient);
  });

  group('get On The Air TV Shows', () {
    final tTvList = TvResponse.fromJson(
            json.decode(readJson('dummy_data/tv/on_the_air.json')))
        .tvList;

    test('should return list of TV Shows Model when the response code is 200',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/on_the_air?$API_KEY')))
          .thenAnswer((_) async =>
              http.Response(readJson('dummy_data/tv/on_the_air.json'), 200));
      // act
      final result = await dataSource.getOnTheAirTvShows();
      // assert
      expect(result, equals(tTvList));
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/on_the_air?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getOnTheAirTvShows();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get Popular TV Shows', () {
    final tTvList =
        TvResponse.fromJson(json.decode(readJson('dummy_data/tv/popular.json')))
            .tvList;

    test('should return list of tv shows when response is success (200)',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY')))
          .thenAnswer((_) async =>
              http.Response(readJson('dummy_data/tv/popular.json'), 200));
      // act
      final result = await dataSource.getPopularTvShows();
      // assert
      expect(result, tTvList);
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getPopularTvShows();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get Top Rated TV Shows', () {
    final tTvList = TvResponse.fromJson(
            json.decode(readJson('dummy_data/tv/top_rated.json')))
        .tvList;

    test('should return list of tv shows when response code is 200 ', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY')))
          .thenAnswer((_) async =>
              http.Response(readJson('dummy_data/tv/top_rated.json'), 200));
      // act
      final result = await dataSource.getTopRatedTvShows();
      // assert
      expect(result, tTvList);
    });

    test('should throw ServerException when response code is other than 200',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getTopRatedTvShows();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get tv show detail', () {
    final tId = 1;
    final tTvDetail = TvDetailResponse.fromJson(
        json.decode(readJson('dummy_data/tv/tv_detail.json')));

    test('should return tv show detail when the response code is 200',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/$tId?$API_KEY')))
          .thenAnswer((_) async =>
              http.Response(readJson('dummy_data/tv/tv_detail.json'), 200));
      // act
      final result = await dataSource.getTvShowDetail(tId);
      // assert
      expect(result, equals(tTvDetail));
    });

    test('should throw Server Exception when the response code is 404 or other',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/$tId?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getTvShowDetail(tId);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get tv show recommendations', () {
    final tTvList = TvResponse.fromJson(
            json.decode(readJson('dummy_data/tv/tv_recommendations.json')))
        .tvList;
    final tId = 1;

    test('should return list of TV Show Model when the response code is 200',
        () async {
      // arrange
      when(mockHttpClient
              .get(Uri.parse('$BASE_URL/tv/$tId/recommendations?$API_KEY')))
          .thenAnswer((_) async => http.Response(
              readJson('dummy_data/tv/tv_recommendations.json'), 200));
      // act
      final result = await dataSource.getTvShowRecommendations(tId);
      // assert
      expect(result, equals(tTvList));
    });

    test('should throw Server Exception when the response code is 404 or other',
        () async {
      // arrange
      when(mockHttpClient
              .get(Uri.parse('$BASE_URL/tv/$tId/recommendations?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getTvShowRecommendations(tId);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('search tv shows', () {
    final tSearchResult = TvResponse.fromJson(json.decode(
            readJson('dummy_data/tv/search_house_of_the_dragon_tv_show.json')))
        .tvList;
    final tQuery = 'House of the Dragon';

    test('should return list of tv shows when response code is 200', () async {
      // arrange
      when(mockHttpClient
              .get(Uri.parse('$BASE_URL/search/tv?$API_KEY&query=$tQuery')))
          .thenAnswer((_) async => http.Response(
              readJson('dummy_data/tv/search_house_of_the_dragon_tv_show.json'),
              200));
      // act
      final result = await dataSource.searchTvShows(tQuery);
      // assert
      expect(result, tSearchResult);
    });

    test('should throw ServerException when response code is other than 200',
        () async {
      // arrange
      when(mockHttpClient
              .get(Uri.parse('$BASE_URL/search/tv?$API_KEY&query=$tQuery')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.searchTvShows(tQuery);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get tv show season detail', () {
    final tId = 1;
    final tSeasonNumber = 1;
    final tTvSeasonDetail = TvSeasonDetailResponse.fromJson(
        json.decode(readJson('dummy_data/tv/tv_season_detail.json')));

    test('should return tv show season detail when the response code is 200',
        () async {
      // arrange
      when(mockHttpClient.get(
              Uri.parse('$BASE_URL/tv/$tId/season/$tSeasonNumber?$API_KEY')))
          .thenAnswer((_) async => http.Response(
              readJson('dummy_data/tv/tv_season_detail.json'), 200));
      // act
      final result = await dataSource.getTvShowSeasonDetail(tId, tSeasonNumber);
      // assert
      expect(result, equals(tTvSeasonDetail));
    });

    test('should throw Server Exception when the response code is 404 or other',
        () async {
      // arrange
      when(mockHttpClient.get(
              Uri.parse('$BASE_URL/tv/$tId/season/$tSeasonNumber?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getTvShowSeasonDetail(tId, tSeasonNumber);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });
}