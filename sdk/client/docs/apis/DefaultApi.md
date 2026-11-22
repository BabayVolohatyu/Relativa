# Relativa.Gateway.Client.Api.DefaultApi

All URIs are relative to *http://localhost:8080*

| Method | HTTP request | Description |
|--------|--------------|-------------|
| [**GetHealth**](DefaultApi.md#gethealth) | **GET** /health | Стан процесу шлюзу |
| [**GetOperatorDigest**](DefaultApi.md#getoperatordigest) | **GET** /api/v1/operator/digest | Поля операторського зрізу |
| [**Login**](DefaultApi.md#login) | **POST** /auth/api/v1/auth/login | Вхід і видача JWT |

<a id="gethealth"></a>
# **GetHealth**
> Health GetHealth ()

Стан процесу шлюзу

Анонімний маршрут процесу Gateway. Тіло збігається з анонімним об'єктом у Program.cs. Метод не проксується в інші сервіси. 


### Parameters
This endpoint does not need any parameter.
### Return type

[**Health**](Health.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
| **200** | Процес шлюзу відповідає. |  -  |
| **502** | Необроблений виняток шлюзу. Пише GlobalExceptionHandler. |  -  |

[[Back to top]](#) [[Back to API list]](../../README.md#documentation-for-api-endpoints) [[Back to Model list]](../../README.md#documentation-for-models) [[Back to README]](../../README.md)

<a id="getoperatordigest"></a>
# **GetOperatorDigest**
> OperatorDigest GetOperatorDigest ()

Поля операторського зрізу

Анонімний маршрут OperatorDigestEndpoints. Чисел угод у тілі немає. Маршрут додано в краш-тесті ЛР10 і лишився в коді після відновлення документації. 


### Parameters
This endpoint does not need any parameter.
### Return type

[**OperatorDigest**](OperatorDigest.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
| **200** | Перелік полів зрізу. |  -  |
| **502** | Необроблений виняток шлюзу. Пише GlobalExceptionHandler. |  -  |

[[Back to top]](#) [[Back to API list]](../../README.md#documentation-for-api-endpoints) [[Back to Model list]](../../README.md#documentation-for-models) [[Back to README]](../../README.md)

<a id="login"></a>
# **Login**
> LoginResponse Login (LoginRequest loginRequest)

Вхід і видача JWT

Публічний шлях шлюзу. YARP знімає префікс /auth, Authentication приймає POST /api/v1/auth/login. Тіло 200 — LoginResponseDto. 400 і 401 пише GlobalExceptionHandler сервісу Authentication з полів status, title, detail. 


### Parameters

| Name | Type | Description | Notes |
|------|------|-------------|-------|
| **loginRequest** | [**LoginRequest**](LoginRequest.md) |  |  |

### Return type

[**LoginResponse**](LoginResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
| **200** | Токен видано. |  -  |
| **400** | FluentValidation відхилив тіло. Title Validation Failed. |  -  |
| **401** | AuthException invalid_credentials. |  -  |
| **502** | Кластер Authentication не відповідає. Живий шлюз без цього процесу повертає 502 і порожнє тіло (Content-Length 0). YARP завершує відповідь сам, тож JSON GlobalExceptionHandler тут не пишеться.  |  -  |

[[Back to top]](#) [[Back to API list]](../../README.md#documentation-for-api-endpoints) [[Back to Model list]](../../README.md#documentation-for-models) [[Back to README]](../../README.md)

